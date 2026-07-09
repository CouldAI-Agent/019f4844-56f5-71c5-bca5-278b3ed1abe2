import 'package:flutter/material.dart';
import '../models/proposal.dart';
import 'proposal_detail_screen.dart';
import 'proposal_form_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Proposal> _proposals = [];

  void _addProposal(Proposal proposal) {
    setState(() {
      _proposals.add(proposal);
    });
  }

  void _updateProposal(Proposal proposal) {
    setState(() {
      final index = _proposals.indexWhere((p) => p.id == proposal.id);
      if (index != -1) {
        _proposals[index] = proposal;
      }
    });
  }

  void _deleteProposal(String id) {
    setState(() {
      _proposals.removeWhere((p) => p.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Proposals'),
        elevation: 0,
      ),
      body: _proposals.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No proposals yet',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push<Proposal>(
                        context,
                        MaterialPageRoute(builder: (context) => const ProposalFormScreen()),
                      );
                      if (result != null) {
                        _addProposal(result);
                      }
                    },
                    child: const Text('Create Proposal'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _proposals.length,
              itemBuilder: (context, index) {
                final proposal = _proposals[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(proposal.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Client: ${proposal.clientName}'),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          final result = await Navigator.push<Proposal>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProposalFormScreen(existingProposal: proposal),
                            ),
                          );
                          if (result != null) {
                            _updateProposal(result);
                          }
                        } else if (value == 'delete') {
                          _deleteProposal(proposal.id);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProposalDetailScreen(proposal: proposal),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: _proposals.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push<Proposal>(
                  context,
                  MaterialPageRoute(builder: (context) => const ProposalFormScreen()),
                );
                if (result != null) {
                  _addProposal(result);
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import '../models/proposal.dart';

class ProposalDetailScreen extends StatelessWidget {
  final Proposal proposal;

  const ProposalDetailScreen({super.key, required this.proposal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(proposal.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Client'),
            Text(proposal.clientName, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Overview'),
            Text(proposal.overview),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Objectives'),
            Text(proposal.objectives),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Scope'),
            Text(proposal.scope),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Timeline'),
            Text(proposal.timeline),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Budget'),
            Text(proposal.budget),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
